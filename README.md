## HandlebarsExec

Bindings for [Handlebars.js][1] using [execjs][2]. Tested using [mini_racer][3], [therubyracer][4], and native [nodejs][5].

## Usage

### Simple Templates

    handlebars = HandlebarsExec::Context.new
    template = handlebars.compile("My Name is {{name}}")
    template.template(name: "Slim Shady") #=> "My Name is Slim Shady"

### Partials

Partials can be added by either adding a string with the partial or by adding a file with the partial registration in it. Referencing a file allows you to use the same files for handlebars on the backend and frontend.

    # passed as a string
    handlebars.register_partial("my_partial", "{{foo}} {{bar}}")

    # passed as a file location
    handlebars.register_partial_file(partial_file_path)

### Helpers

Helpers can be added by either adding a string with the helper or by adding a file with the helper registration in it. Referencing a file allows you to use the same files for handlebars on the backend and frontend.

    # passed as a string 
    handlebars.register_helper("formatPhoneNumber", <<-HELP)
      function(phoneNumber) {
        phoneNumber = phoneNumber.toString();
        return "(" + phoneNumber.substr(0,3) + ") " + phoneNumber.substr(3,3) + "-" + phoneNumber.substr(6,4);
      }
    HELP

    # passed as a file location
    handlebars.register_partial_file(partial_file_path)

## Test

Testing in different JS runtimes are handled using [Appraisal][6]. Once installed, the following will setup the different js runtime test setups

    appraisal install

Tests can then be run like so:

    appraisal rake


[1]: http://github.com/wycats/handlebars.js "Handlebars JavaScript templating library"
[2]: https://github.com/rails/execjs "execjs"
[3]: https://github.com/discourse/mini_racer "mini_racer"
[4]: http://github.com/cowboyd/therubyracer "The Ruby Racer"
[5]: https://nodejs.org/ "Node.js"
[6]: https://github.com/thoughtbot/appraisal "Appraisal"
