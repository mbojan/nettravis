#!/usr/bin/env sh

choco install zip
choco install Rtools

choco install -y r.project &&
export R_VERSION=`ls 'C:\Program Files\R\'` &&
export PATH=$PATH:';C:\Program Files\R\'$R_VERSION'\bin\x64' &&
echo 'options(repos = "https://cloud.r-project.org", install.packages.compile.from.source = "never")' > ~/.Rprofile.site &&
export R_PROFILE=~/.Rprofile.site &&

Rscript.exe -e 'sessionInfo()' &&
Rscript.exe -e 'install.packages("devtools", dependencies = TRUE);if (!all("devtools" %in% installed.packages())) { q(status = 1, save = "no")}' &&
Rscript.exe -e 'deps <- devtools::dev_package_deps(dependencies = TRUE); inst <- installed.packages(); install.packages(deps$package[!deps$package %in% inst[,"Package"]])' &&
Rscript.exe -e 'install.packages("zeallot", dependencies = TRUE)' &&
Rscript.exe -e 'devtools::session_info(installed.packages()[, "Package"])' &&

export PKG_NAME="$(perl -ne '$package = $1 if (/^Package:\s*(\S+)/); END { print "${package}" }' DESCRIPTION)"
export PKG_VERSION="$(perl -ne '$version = $1 if (/^Version:\s*(\S+)/); END { print "${version}" }' DESCRIPTION)"
export PKG_TARBALL="$(perl -ne '$version = $1 if (/^Version:\s(\S+)/); $package = $1 if (/^Package:\s*(\S+)/); END { print "${package}_$version.tar.gz" }' DESCRIPTION)"
export PKG_ZIP="$(perl -ne '$version = $1 if (/^Version:\s(\S+)/); $package = $1 if (/^Package:\s*(\S+)/); END { print "${package}_$version.zip" }' DESCRIPTION)"
