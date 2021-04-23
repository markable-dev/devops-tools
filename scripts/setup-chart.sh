#!/bin/sh

# Generate a new chart base on markable/markable-base chart

set -e

USAGE="Usage: $0 <new_chart_dir>[ <base_chart>[ <base_chart_version>]]"

new_chart_dir=$1
base_chart=${2:-"markable/markable-base"}
base_chart_version=$3
tmp_base_dir=.helm-charts

if [[ ! -n "$new_chart_dir" ]]; then
  echo "$USAGE"
  exit 1
fi

if [[ -e "$new_chart_dir" ]]; then
  echo "$new_chart_dir already exists."
  exit 1
fi

chart_name=$(basename $new_chart_dir)
tmp_dir=$tmp_base_dir/$(basename $base_chart)

version_opt=""
if [[ -n "$base_chart_version" ]]; then
  version_opt=" --version $base_chart_version"
fi

mkdir -p $new_chart_dir
mkdir -p $tmp_base_dir

helm repo update
helm pull $version_opt --untar $base_chart --untardir $tmp_base_dir
rm -rf $tmp_dir/charts $tmp_dir/values-test.yaml
cp -R $tmp_dir/* $new_chart_dir/
rm -rf $tmp_dir

helm dep build --skip-refresh $new_chart_dir

yq e ".name = \"$chart_name\"" -i $new_chart_dir/Chart.yaml
yq e ".version = \"0.0.1\"" -i $new_chart_dir/Chart.yaml

if which code; then
  code $new_chart_dir/Chart.yaml
else
  vim $new_chart_dir/Chart.yaml
fi
