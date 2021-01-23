metadata    :name        => "puppetca",
            :description => "Checks the status of a puppet certificate",
            :author      => "R.I.Pienaar <rip@devco.net>",
            :license     => "ASL 2.0",
            :version     => "4.0.2",
            :url         => "https://github.com/choria-plugins/puppetca-agent",
            :timeout     => 3

requires :mcollective => "2.2.1"

dataquery :description => "Puppetca" do
  input :query,
        :prompt => "Certificate name",
        :description => "Certificate name",
        :type => :string,
        :validation => :shellsafe,
        :maxlength => 50

  output :status,
         :description => "Has the cert been signed, is it awaiting signing or could it not be found.",
         :display_as => "Cert Status"
end
