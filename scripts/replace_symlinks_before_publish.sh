#!/bin/sh

cd packages
rm bdk_dart/native bdk_dart_base/native
cp -r bdk_dart_ffi/native bdk_dart/native
git rm --cached bdk_dart/native
cp -r bdk_dart_ffi/native bdk_dart_base/native
git rm --cached bdk_dart_base/native
