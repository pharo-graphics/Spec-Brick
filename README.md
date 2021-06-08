# Spec-Brick

Brick backend for [Spec](https://github.com/pharo-spec/Spec). 

Spec is a [Pharo](https://pharo.org/) library for describing user interfaces. You describe a UI by composing the "presenters" and by connecting them via block closures.

More concretely, a Spec UI is a tree of `SpPresenter`, that is opened in the context of an application (`SpApplication`) that, among others, indicates what is the backend.

Our backend (`SpBrickBackend`) provides the adapters (hierarchy of `SpBrickAdapter`) to make the `Brick` widgets to act as the tree of presenters describe.

Other Spec backends are:
- Morphic (the default)
- [GTK](https://github.com/pharo-spec/Spec-Gtk)

## Example

This repository has a demo Spec UI that you can open with the default backend (**Morphic**) using this snippet:

```smalltalk
| aModel aPresenter |
aModel := SpToDoList exampleWithSomeTasks.
aPresenter := SpToDoPresenter on: aModel.
aPresenter openWithSpec.
```

To open it using this **Brick** backend, specify the backend in an application:

```smalltalk
| app aModel aPresenter |
app := SpApplication new 
	useBackend: #Brick;
	yourself.
aModel := SpToDoList exampleWithSomeTasks.
aPresenter := SpToDoPresenter newApplication: app model: aModel.
aPresenter openWithSpec.
```



## Installation

Evaluate the following script on [Pharo 9](https://pharo.org/download):

```smalltalk
Metacello new
	baseline: 'SpecBrick';
	repository: 'github://pharo-graphics/Spec-Brick:main/src';
	onConflictUseIncoming;
	load
```

Alternatively, you can do it by terminal (MacOS, linux... and should work as well in Windows with MINGW64). 
Create a directory and execute `<this_repo>/scripts/build.sh`, which first downloads the Pharo image and VM and then loads the project.


## License and Contributing

This code is licensed under the [MIT license](./LICENSE.md).
