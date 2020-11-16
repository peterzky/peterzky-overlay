self: super: {
  # machine learning environment
  ml-env = super.myEnvFun {
    name = "ml";
    buildInputs = [
      (self.python36.withPackages (ps:
      with ps; [
        opencv3
        Keras
        tensorflow
        numpy
        matplotlib
        yapf
        jedi
        pillow
        jupyter
      ]))
      # ca-certificates for networking
      super.cacert
    ];
    shell = "${super.bashInteractive}/bin/bash";
  };

  # python image processing
  im-env = super.myEnvFun {
    name = "im";
    buildInputs = [
      (self.python3.withPackages (ps:
      with ps; [
        opencv3
        numpy
        matplotlib
        scipy
        pylint
        yapf
        jedi
        pillow
        pandas
        jupyter
      ]))
      # ca-certificates for networking
      super.cacert
    ];
    shell = "${super.bashInteractive}/bin/bash";

  };

  # cpp development environment
  #   cpp-env = super.myEnvFun {
  #     name ="cpp";
  #     stdenv = super.clangStdenv;
  #     buildInputs = with super; [cmake bear cquery gdb opencv3];
  #     shell = "${super.bashInteractive}/bin/bash";
  #      };
}
