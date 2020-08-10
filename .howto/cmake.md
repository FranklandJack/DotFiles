# CMake Related Operation

## Install Component

The following command will install a single named component from the build
into the `CMAKE_INSTALL_PREFIX` path. This is useful when you only want to install
a single component rather than `ninja install` which would install everything.

### Command Line
```
cmake -DCOMPONENT=component_name -P cmake_install.cmake
```

### Explanation
* `COMPONENT` Name of component to install.
* `cmake_install.cmake` this is the CMake install script which CMake uses to install
targets.
