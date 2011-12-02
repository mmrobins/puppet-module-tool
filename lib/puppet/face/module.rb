require 'puppet/face'
require 'puppet/module/tool'

Puppet::Face.define(:module, '0.0.1') do
  copyright "Puppet Labs", 2011
  license   "Apache 2 license; see COPYING"

  summary "Puppet Module Tool"
  description <<-'EOT'
    Interacts with the forge
  EOT
  action(:install) do
    summary "Install a module (eg, 'user-modname') from a repository or file"

    option "--version VERSION" do
      summary "Version to install (can be a requirement, eg '>= 1.0.3', defaults to latest version)"
    end

    option "--[no-]force" do
      summary "Force overwrite of existing module, if any"
    end

    option "--install-dir INSTALL_DIR" do
      summary "The directory into which modules are installed"
    end

    arguments "<name>"

    when_invoked do |name, options|
      #method_option_repository
      Puppet::Module::Tool::Applications::Installer.run(name, options)
    end
  end
end
