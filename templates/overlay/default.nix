_:
let
  this = {
    name = "package";
  };
in
(final: prev: {
  ${this.name} = prev.${this.name}.override {
    # Your configuration here
  };
})
