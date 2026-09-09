@echo off
title Impulse Data Entry Server
cd /d "%~dp0\.."
echo ====================================================
echo  Impulse DEX - Data Entry Tool Launcher
echo ====================================================
echo Starting local companion server...
dart run bin/data_entry.dart
pause
