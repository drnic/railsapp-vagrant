maintainer        "Opscode, Inc."
maintainer_email  "cookbooks@opscode.com"
license           "Apache 2.0"
description       "Sets up RVM"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.rdoc'))
version           "0.0.1"
suggests          "ruby"

recipe "rvm::default", "Installs RVM"
recipe "rvm::ree", "Installs Enterprise Ruby under RVM"
