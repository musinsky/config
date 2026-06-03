<!-- markdownlint-disable MD033 MD041-->
<p align="right">last edit: 2026-06-03</p>
<!-- markdownlint-enable  MD033 MD041-->

# C/C++ Configuration in VS Code

- VS Code docs: [Using C++ on Linux in VS Code](https://code.visualstudio.com/docs/cpp/config-linux)

- Install
  [C/C++ Extension Pack (4-pack)](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools-extension-pack)
  and [Makefile Tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.makefile-tools)

- VS Code docs: [C++ extension settings](https://code.visualstudio.com/docs/cpp/customize-cpp-settings)
  and [Configure C/C++ IntelliSense](https://code.visualstudio.com/docs/cpp/configure-intellisense)

- C/C++ Configuration means configuration in
  [C/C++ for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
  extension

---
VS Code 1.122.1, Fedora 44 with gcc 16.1.1 and clang 22.1.6 (2026-06). ROOT installed
manually into unusual `/cern/root/` dir (compiled from source code).

> **_`CC++ Diagnostics.log` files:_**
>
> - Command Palette (Ctrl+Shift+P)> **C/C++: Log Diagnostics**
> - From OUTPUT panel _Save output As..._
>
> Log Diagnostics also saved in `${HOME}/.config/Code/logs/` dir as `<n>-CC++ Diagnostics.log` files

## 01 - default

`01.CC++.Diagnostics.log`  
C/C++ IntelliSense vybral by default CLANG a nie predpokladany (a ziaduci) GCC.

## 02 - default and open folder with C++ file

Vytvorime dir `${HOME}/HSIMPLE/` s jednym suborom `hsimple.C` (from ROOT tutorials),
ktoru nasledne otvorime vo VS Code. Status bar (dolna lista) indikuje `C` ako `Select Language Mode`
a `Linux` ako `C/C++ Configuration` (kliknutim na `Select Language Mode` zmenime `C` mode
na `C++` mode).

`Linux` je default `C/C++ Configuration`, ktory C/C++ IntelliSense automaticky
vytvoril na Fedora, kde boli sucasne nainstalovane CLANG aj GCC.

`02.CC++.Diagnostics.log`  
Rovnaky log ako predchadzajuci `01.CC++.Diagnostics.log` s doplnujucim info.
By default `Linux` ako `C/C++ Configuration` (by default CLANG a nie GCC).

## 03 - default and save default C/C++ Configuration as `c_cpp_properties.json` file

Kliknutim na `Linux` (aktualna `C/C++ Configuration`) editujeme (alebo vyberame)
`C/C++ Configuration` cez UI, kde su jednotlive polozky zdokumentovane,
alebo priamo ako JSON file, pre manualnu konfiguraciu.

Or by running the command:

- Command Palette (Ctrl+Shift+P)> **C/C++: Edit Configurations (UI or JSON)**
- Command Palette (Ctrl+Shift+P)> **C/C++: Select a Configurations**

V tomto momente sa v current dir vytvorila subdir `.vscode/` so suborom
`c_cpp_properties.json`, ktory obsahuje stale default `Linux` ako
`C/C++ Configuration` v JSON formate.

`03.c_cpp_properties.json`  
`03.CC++.Diagnostics.log`  
Zatial sme stale default `C/C++ Configuration` nezmenili, takze log je podny ako predchadzajuce,
ale s tym rozdielom, ze jednotlive polozky su uz zadefinovane explicitne.

## 04 - change default C/C++ Configuration

Editujeme `c_cpp_properties.json` file, t.j. menime `C/C++ Configuration`

`04.c_cpp_properties.json`  
`04.CC++.Diagnostics.log`

> **_POZOR_**
>
> `compilerPath` v `C/C++ Configuration` ma vyssiu prioritu  ako `intelliSenseMode`.  
> To znamena, ze napr. nastavenie `"compilerPath": "/usr/bin/clang"` automaticky
> zmeni `intelliSenseMode` na `linux-clang-x64` a to aj v pripade, ak by sme mali
> explicitne nastavene `"intelliSenseMode": "linux-gcc-x64"`.
>
> Hierarchia je pravdepodobne asi nasledovna:
>
>- `compile_commands.json`
>- `configurationProvider` (CMake Tools or Makefile Tools extensions)
>- `compilerPath`
>- C/C++ IntelliSense autodetection
>- `intelliSenseMode`

## 10 - default and open folder with Makefile

Vytvorime dir `${HOME}/STRELA/` of Strela project and with Makefile, ktoru nasledne
otvorime. VS Code pri otvarani tejto folder zisti pritomnost Makefile:

_Would you like to configure C++ IntelliSense for this  
workspace using information from your Makefiles?_

Or by running the command:

- Command Palette (Ctrl+Shift+P)> **Makefile: Configure**

`10.CC++.Diagnostics.log`  
Podobny log ako `02.CC++.Diagnostics.log`, kedze sa pouziva default `Linux`
ako `C/C++ Configuration`, ale s jednym podstatnym rozdielom:
`"configurationProvider": "ms-vscode.makefile-tools"`.  
Ako uz bolo spomenute skor, tento parameter ma vyssiu prioritu ako `compilerPath`
a preto udaje ako Compiler Path alebo Include Paths ziskane priamo z `Makefile`
(resp. `CMakeLists.txt`) maju vyssiu prioritu a preto C/C++ IntelliSense nakoniec
s GCC (definovany cez `Makefile`) a nie s CLANG (definovany cez `compilerPath`).

## 11 - change default C/C++ Configuration

Editujeme `c_cpp_properties.json` file, t.j. menime `C/C++ Configuration`

`11.c_cpp_properties.json`  
`11.CC++.Diagnostics.log`  
Subor `11.c_cpp_properties.json` je takmer identicky ako `04.c_cpp_properties.json`,
ale s jednym riadkom navyse: `"configurationProvider": "ms-vscode.makefile-tools"`.

Pridanie `"includePath": "/cern/root/include/**"` sa moze javit ako zbytocne,
kedze sa tato Include Path pridava automaticky cez `Makefile`. Je vsak potrebne
pre subory, ktore nie su priamo v `Makefile`, typicky pre rozne ROOT macros ako
napr. `Strela.C`.

## Notes

- Ak mame zdrojovy kod pre ROOT je vhodne tuto cestu pridat do
  [`browse`](https://code.visualstudio.com/docs/cpp/customize-cpp-settings#_browse-properties).
