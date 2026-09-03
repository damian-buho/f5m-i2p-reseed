# SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
#
# SPDX-License-Identifier: MIT

# shellcheck shell=bash

  # Build the synthetic netDb fixture helper so the pipeline (empty netDb)
  # can still satisfy the strict /i2pseeds.su3 healthcheck. Reuses the
  # reseed-tools go.mod (same common/crypto versions) — no extra deps.
  b19-log info "RESEED" "$(_ "Building reseed-fixture helper")"

  cat > "${B19_HOME}/fixture.go" <<'GOEOF'
// SPDX-FileCopyrightText: 2026 Damián Búho <damian.buho@proton.me>
// SPDX-License-Identifier: MIT
package main

import (
	"bytes"
	"flag"
	"fmt"
	"os"
	"path/filepath"
	"time"

	"github.com/go-i2p/common/certificate"
	"github.com/go-i2p/common/data"
	"github.com/go-i2p/common/key_certificate"
	"github.com/go-i2p/common/keys_and_cert"
	"github.com/go-i2p/common/router_address"
	"github.com/go-i2p/common/router_identity"
	"github.com/go-i2p/common/router_info"
	"github.com/go-i2p/common/signature"
	"github.com/go-i2p/crypto/ed25519"
	elgamal "github.com/go-i2p/crypto/elg"
	"github.com/go-i2p/crypto/rand"
	"github.com/go-i2p/crypto/types"
)

func main() {
	netdb := flag.String("netdb", "", "netDb directory to populate")
	count := flag.Int("count", 82, "number of routerInfos to generate")
	flag.Parse()
	if *netdb == "" {
		fmt.Fprintln(os.Stderr, "--netdb is required")
		os.Exit(1)
	}
	if err := os.MkdirAll(*netdb, 0755); err != nil {
		fmt.Fprintf(os.Stderr, "mkdir %s: %v\n", *netdb, err)
		os.Exit(1)
	}
	for i := 0; i < *count; i++ {
		ri, err := genRI(time.Now())
		if err != nil {
			fmt.Fprintf(os.Stderr, "gen %d: %v\n", i, err)
			os.Exit(1)
		}
		b, err := ri.Bytes()
		if err != nil {
			fmt.Fprintf(os.Stderr, "bytes %d: %v\n", i, err)
			os.Exit(1)
		}
		h, _ := ri.RouterIdentity().Hash()
		name := fmt.Sprintf("routerInfo-%x-%04d.dat", h[:4], i)
		path := filepath.Join(*netdb, name)
		if _, err := os.Stat(path); err == nil {
			continue
		}
		if err := os.WriteFile(path, b, 0644); err != nil {
			fmt.Fprintf(os.Stderr, "write %s: %v\n", path, err)
			os.Exit(1)
		}
		fmt.Printf("wrote %s\n", name)
	}
	fmt.Printf("seeded %d routerInfos in %s\n", *count, *netdb)
}

func genRI(published time.Time) (*router_info.RouterInfo, error) {
	edPriv, edPub := genEd25519()
	elgPub := genElGamal()
	cert := genCert()
	ident := genIdentity(elgPub, edPub, cert)
	addrs := genAddrs()
	opts := map[string]string{
		"router.version": "0.9.67",
		"caps":           "R",
	}
	return router_info.NewRouterInfo(ident, published, addrs, opts, &edPriv, signature.SIGNATURE_TYPE_EDDSA_SHA512_ED25519)
}

func genEd25519() (ed25519.Ed25519PrivateKey, types.SigningPublicKey) {
	k, err := ed25519.GenerateEd25519Key()
	if err != nil {
		panic(err)
	}
	priv := k.(ed25519.Ed25519PrivateKey)
	pub, err := priv.Public()
	if err != nil {
		panic(err)
	}
	return priv, pub.(types.SigningPublicKey)
}

func genElGamal() elgamal.ElgPublicKey {
	var priv elgamal.PrivateKey
	if err := elgamal.ElgamalGenerate(&priv.PrivateKey, rand.Reader); err != nil {
		panic(err)
	}
	var pub elgamal.ElgPublicKey
	y := priv.PublicKey.Y.Bytes()
	if len(y) > 256 {
		panic("Y too large")
	}
	copy(pub[256-len(y):], y)
	return pub
}

func genCert() *certificate.Certificate {
	var payload bytes.Buffer
	sigType, _ := data.NewIntegerFromInt(7, 2)
	cryptoType, _ := data.NewIntegerFromInt(0, 2)
	payload.Write(*sigType)
	payload.Write(*cryptoType)
	cert, err := certificate.NewCertificateWithType(certificate.CERT_KEY, payload.Bytes())
	if err != nil {
		panic(err)
	}
	return cert
}

func genIdentity(elgPub elgamal.ElgPublicKey, edPub types.SigningPublicKey, cert *certificate.Certificate) *router_identity.RouterIdentity {
	kc, err := key_certificate.KeyCertificateFromCertificate(cert)
	if err != nil {
		panic(err)
	}
	pubSize := kc.CryptoSize()
	sigSize := kc.SigningPublicKeySize()
	padSize := keys_and_cert.KEYS_AND_CERT_DATA_SIZE - pubSize - sigSize
	padding := make([]byte, padSize)
	if _, err := rand.Read(padding); err != nil {
		panic(err)
	}
	ri, err := router_identity.NewRouterIdentity(elgPub, edPub, cert, padding)
	if err != nil {
		panic(err)
	}
	return ri
}

func genAddrs() []*router_address.RouterAddress {
	opts := map[string]string{
		"host": "1.2.3.4",
		"port": "12345",
	}
	ra, err := router_address.NewRouterAddress(3, time.Time{}, "NTCP2", opts)
	if err != nil {
		panic(err)
	}
	return []*router_address.RouterAddress{ra}
}
GOEOF

  b19-run "RESEED" "$(_ "Compile reseed-fixture")" -- \
    go build -ldflags="-s -w" -o reseed-fixture fixture.go

  b19-strip "RESEED" reseed-fixture

  b19-run "RESEED" "$(_ "Make directory in export")" -- \
    mkdir -p /export/usr/local/bin

  b19-run "RESEED" "$(_ "Copy fixture helper to export")" -- \
    cp reseed-fixture /export/usr/local/bin/reseed-fixture

  b19-run "RESEED" "$(_ "Clean fixture source")" -- \
    rm -f fixture.go reseed-fixture
