#!/bin/bash

set -e

# get GPG key
curl -O https://keybase.io/codecovsecurity/pgp_keys.asc
# verify fingerprint
if ! gpg --import --import-options show-only --with-fingerprint pgp_keys.asc | grep "2703 4E7F DB85 0E0B BC2C  62FF 806B B28A ED77 9869"; then
    echo "Downloaded GPG key has wrong fingerprint"
    exit 1
fi
# import key into special keyring used by gpgv below
gpg --no-default-keyring --keyring ~/.gnupg/trustedkeys.kbx --import pgp_keys.asc

# get uploader with signatures
curl -O https://uploader.codecov.io/latest/linux/codecov
curl -O https://uploader.codecov.io/latest/linux/codecov.SHA256SUM
curl -O https://uploader.codecov.io/latest/linux/codecov.SHA256SUM.sig

# verify
gpgv codecov.SHA256SUM.sig codecov.SHA256SUM
shasum -a 256 -c codecov.SHA256SUM

# execute
chmod +x codecov
./codecov -Z -v -s ../ -F BBGG || (sleep 30; ./codecov -Z -v -s ../ -F BBGG || (sleep 30; ./codecov -Z -v -s ../ -F BBGG))
./codecov -Z -v -s ../ -F Bicomplexes || (sleep 30; ./codecov -Z -v -s ../ -F Bicomplexes || (sleep 30; ./codecov -Z -v -s ../ -F Bicomplexes))
./codecov -Z -v -s ../ -F ComplexesCategories || (sleep 30; ./codecov -Z -v -s ../ -F ComplexesCategories || (sleep 30; ./codecov -Z -v -s ../ -F ComplexesCategories))
./codecov -Z -v -s ../ -F DerivedCategories || (sleep 30; ./codecov -Z -v -s ../ -F DerivedCategories || (sleep 30; ./codecov -Z -v -s ../ -F DerivedCategories))
./codecov -Z -v -s ../ -F HomotopyCategories || (sleep 30; ./codecov -Z -v -s ../ -F HomotopyCategories || (sleep 30; ./codecov -Z -v -s ../ -F HomotopyCategories))
./codecov -Z -v -s ../ -F QuotientCategories || (sleep 30; ./codecov -Z -v -s ../ -F QuotientCategories || (sleep 30; ./codecov -Z -v -s ../ -F QuotientCategories))
./codecov -Z -v -s ../ -F StableCategories || (sleep 30; ./codecov -Z -v -s ../ -F StableCategories || (sleep 30; ./codecov -Z -v -s ../ -F StableCategories))
./codecov -Z -v -s ../ -F ToolsForHigherHomologicalAlgebra || (sleep 30; ./codecov -Z -v -s ../ -F ToolsForHigherHomologicalAlgebra || (sleep 30; ./codecov -Z -v -s ../ -F ToolsForHigherHomologicalAlgebra))
./codecov -Z -v -s ../ -F TriangulatedCategories || (sleep 30; ./codecov -Z -v -s ../ -F TriangulatedCategories || (sleep 30; ./codecov -Z -v -s ../ -F TriangulatedCategories))
