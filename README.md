# Spec-Brick
Bindings to have Brick as backend of Spec2


## Installation

Evaluate the following script on [Pharo 9](https://pharo.org/download):

```smalltalk
Metacello new
        baseline: 'SpecBrick';
        repository: 'github://pharo-graphics/Spec-Brick/src';
        load.
```

Alternatively, you can do it by terminal (MacOS, linux... and should work as well in Windows with MINGW64). 
Create a directory and execute `<this_repo>/scripts/build.sh`, which first downloads the Pharo image and VM and then loads the project.


## License and Contributing

This code is licensed under the [MIT license](./LICENSE.md).
