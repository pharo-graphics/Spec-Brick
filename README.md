# Spec-Brick

[![License](https://img.shields.io/github/license/pharo-graphics/Spec-Brick.svg)](./LICENSE)
[![Tests](https://github.com/pharo-graphics/Spec-Brick/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Spec-Brick/actions/workflows/test.yml)

[Brick](https://github.com/pharo-graphics/Brick) backend for [Spec](https://github.com/pharo-spec/Spec). 

Brick is a widget library on top of [Bloc](https://github.com/pharo-graphics/Bloc).

Spec is a [Pharo](https://pharo.org/) library for describing user interfaces. You describe a UI by composing the "presenters" and by connecting them via block closures.

More concretely, a Spec UI is a tree of `SpPresenter`, that is opened in the context of an application (`SpApplication`) that, among others, indicates what is the backend.

Our backend (`SpBrickBackend`) provides the adapters (hierarchy of `SpBrickAdapter`) to make the `Brick` widgets to act as the tree of presenters describe.

Other Spec backends are:
- Morphic (the default)
- [GTK](https://github.com/pharo-spec/Spec-Gtk)

## Warning

:warning: 
This backend still **covers a very small part of Spec**: partial coverage of a few widgets. To see the current state, you can check the Example subsection below, the SUnit tests, and the hierarchy of `SpBrickAdapter`.
:warning:

## Example

This repository has a demo Spec UI that you can open with the default backend (**Morphic**) using this snippet:

```smalltalk
| aModel aPresenter |
aModel := SpToDoList exampleWithSomeTasks.
aPresenter := SpToDoListPresenter on: aModel.
aPresenter openWithSpec.
```

To open it using this **Brick** backend, specify the backend in an application:

```smalltalk
| app aModel aPresenter |
app := SpApplication new 
	useBackend: #Brick;
	yourself.
aModel := SpToDoList exampleWithSomeTasks.
aPresenter := SpToDoListPresenter newApplication: app model: aModel.
aPresenter openWithSpec.
```

Videos:
- https://youtu.be/nYZS3zqdCQM (June/2021 ~ commit 50dfb5f)
- https://youtu.be/DGqeRnspGas (June/2021 ~ commit 89b6cbe)


## Installation

Evaluate the following script on [Pharo 9 or 10](https://pharo.org/download):

```smalltalk
Metacello new
	baseline: 'SpecBrick';
	repository: 'github://pharo-graphics/Spec-Brick/src';
	onConflictUseIncoming;
	load
```

Alternatively, you can do it by terminal (MacOS, linux... and should work as well in Windows with MINGW64). 
Create a directory and execute `<this_repo>/scripts/build.sh`, which first downloads the Pharo image and VM and then loads the project.

## CI status including dependencies


| Project | Badge |
| ------- | ----- |
| Sparta | [![Sparta CI](https://github.com/pharo-graphics/sparta/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/sparta/actions/workflows/test.yml) |
| Fenster | [![Fenster CI](https://github.com/pharo-graphics/fenster/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/fenster/actions/workflows/test.yml) |
| Bloc | [![Bloc CI](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Bloc/actions/workflows/test.yml) |
| BlocPac | [![BlocPac CI](https://github.com/pharo-graphics/bloc-pac/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/bloc-pac/actions/workflows/test.yml) |
| Brick | [![Brick CI](https://github.com/pharo-graphics/Brick/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Brick/actions/workflows/test.yml) |
| Spec-Brick | [![Spec-Brick CI](https://github.com/pharo-graphics/Spec-Brick/actions/workflows/test.yml/badge.svg)](https://github.com/pharo-graphics/Spec-Brick/actions/workflows/test.yml) |

## License

This code is licensed under the [MIT license](./LICENSE).
