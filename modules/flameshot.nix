{
  pkgs,
  self,
  ...
}:

{
  # TODO: remove override after fixed:
  # https://github.com/NixOS/nixpkgs/pull/507424#issuecomment-4304361179
  nixpkgs.overlays = [
    (final: prev: {
      flameshot = prev.flameshot.overrideAttrs (old: rec {
        version = "13.3.0";
        src = old.src.overrideAttrs (oldsrc: {
          tag = "v${version}";
          hash = "sha256-RyoLniRmJRinLUwgmaA4RprYAVHnoPxCP9LyhHfUPe0=";
        });
        patches = [
          (prev.writeTextFile {
            name = "load-missing-deps.patch";
            text = ''
              --- a/CMakeLists.txt	2025-08-21 13:12:55
              +++ b/CMakeLists.txt	2025-08-21 13:16:26
              @@ -24,28 +24,8 @@
               #Needed due to linker error with QtColorWidget
               set(CMAKE_POSITION_INDEPENDENT_CODE ON)
               
              +find_package(QtColorWidgets REQUIRED)
               
              -# Dependency can be fetched via flatpak builder
              -if(EXISTS "''${CMAKE_SOURCE_DIR}/external/Qt-Color-Widgets/CMakeLists.txt")
              -    add_subdirectory("''${CMAKE_SOURCE_DIR}/external/Qt-Color-Widgets" EXCLUDE_FROM_ALL)
              -else()
              -    FetchContent_Declare(
              -        qtColorWidgets
              -        GIT_REPOSITORY https://gitlab.com/mattbas/Qt-Color-Widgets.git
              -        GIT_TAG 352bc8f99bf2174d5724ee70623427aa31ddc26a
              -    )
              -  #Workaround for duplicate GUID in windows WIX installer
              -  if (WIN32)
              -      FetchContent_GetProperties(qtColorWidgets)
              -      if(NOT qtcolorwidgets_POPULATED)
              -          FetchContent_Populate(qtColorWidgets)
              -          add_subdirectory(''${qtcolorwidgets_SOURCE_DIR} ''${qtcolorwidgets_BINARY_DIR} EXCLUDE_FROM_ALL)
              -      endif()
              -  else()
              -      FetchContent_MakeAvailable(qtColorWidgets)
              -  endif()
              -endif()
              -
               # This can be read from ''${PROJECT_NAME} after project() is called
               if (APPLE)
                 set(CMAKE_OSX_DEPLOYMENT_TARGET "10.15" CACHE STRING "Minimum OS X deployment version")
              @@ -133,12 +113,7 @@
               option(BUILD_STATIC_LIBS ON)
               
               if (APPLE)
              -  FetchContent_Declare(
              -      qHotKey
              -      GIT_REPOSITORY https://github.com/flameshot-org/QHotkey
              -      GIT_TAG master
              -  )
              -  FetchContent_MakeAvailable(QHotKey)
              +  find_package(QHotKey REQUIRED)
               endif()
               
               add_subdirectory(src)
            '';
          })
        ];
      });
    })
  ];

  hm-gep.services.flameshot = {
    enable = true;
    package = self.lib.maybeCachePackage self pkgs.flameshot;
    settings = {
      General = {
        disabledTrayIcon = true;
        predefinedColorPaletteLarge = true;
        showHelp = false;
        showAbortNotification = false;
      };
      Shortcuts = {
        TYPE_ARROW = "a";
        TYPE_MARKER = "ctrl+m";
        TYPE_PIXELATE = "b";
        TYPE_CIRCLE = "c";
        TYPE_CIRCLECOUNT = "x"; # incrmenting number bubble
        TYPE_SELECTION = "r"; # hollow rectangle
        TYPE_RECTANGLE = "shift+r"; # filled rectangle
        TYPE_MOVESELECTION = "m";
        TYPE_MOVE_LEFT = "h";
        TYPE_MOVE_DOWN = "j";
        TYPE_MOVE_UP = "k";
        TYPE_MOVE_RIGHT = "l";
        TYPE_RESIZE_LEFT = "ctrl+h";
        TYPE_RESIZE_DOWN = "ctrl+j";
        TYPE_RESIZE_UP = "ctrl+k";
        TYPE_RESIZE_RIGHT = "ctrl+l";
        TYPE_UNDO = "u";
        TYPE_REDO = "shift+u";
        TYPE_COPY = "y";
        TYPE_PIN = "return";
      };
    };
  };
}
