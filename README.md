# Choria PuppetCA Agent

The puppetca agent lets you sign, list, revoke, clean and determine the status of certificates on your
Puppet Certificate Authorities

## Actions

This agent provides the following actions, for details about each please run `mco plugin doc agent/puppetca`

 * **clean** - Performs a puppetca --clean on a certficate
 * **list** - Lists all requested and signed certificates
 * **revoke** - Revokes a certificate by doing the same as clean
 * **sign** - Signs a certificate request
 * **status** - Find a certificate's status

## Agent Installation

Add the agent and client:

```yaml
mcollective::plugin_classes:
  - mcollective_agent_puppetca
```

## Configuration

You can configure the path to the Puppet Cert command via Hiera:

```yaml
mcollective_agent_puppetca::config:
  puppetca: /bin/puppet cert
```

The default path is `/opt/puppetlabs/bin/puppet cert`

## Usage

### List

    % mco rpc puppetca list
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ============================================================> ] 1 / 1


    puppetca.example.com
       Waiting CSRs: ["host2.example.com", "host3.example.com"]
             Signed: ["host1.example.com", "host4.example.com"]



    Finished processing 1 / 1 hosts in 67.85 ms

### Sign

    % mco rpc puppetca sign certname=host3.example.com
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ============================================================> ] 1 / 1


    puppetca.example.com                             Unknown Request Status
       Already have a certificate for host3.example.com. Not attempting to sign again



    Finished processing 1 / 1 hosts in 48.25 ms

### Revoke

    % mco rpc puppetca revoke certname=host1.example.com
    Discovering hosts using the mc method for 2 second(s) .... 1

     * [ ============================================================> ] 1 / 1


    puppetca.example.com
       Result: Notice: Revoked certificate with serial 35
               Notice: Removing file Puppet::SSL::Certificate host1.example.com at '/var/lib/puppet/ssl/ca/signed/host1.example.com.pem'
               Notice: Removing file Puppet::SSL::Certificate host1.example.com at '/var/lib/puppet/ssl/certs/host1.example.com.pem'
               Notice: Removing file Puppet::SSL::CertificateRequest host1.example.com at '/var/lib/puppet/ssl/certificate_requests/host1.example.com.pem'
               Notice: Removing file Puppet::SSL::Key host1.example.com at '/var/lib/puppet/ssl/private_keys/host1.example.com.pem'



    Finished processing 1 / 1 hosts in 1882.27 ms

### Status

    % mco rpc puppetca status certname=host2.example.com
    Discovering hosts using the mc method for 2 second(s) .... 1

    * [ ============================================================> ] 1 / 1


    puppetca.example.com
      Result: awaiting signature



    Finished processing 1 / 1 hosts in 56.76 ms

## Data Plugin

The Puppetca agent also supplies a data plugin which uses the Puppetca agent to check the current status of a
certificate. The data plugin will return 'signed', 'waiting' and 'missing', and can be used during discovery
or any other place where the MCollective discovery langauge is used.

In this example we lookup all nodes that have a cert "host2.example.com" in a waiting state.

    % mco find -S "puppetca('host2.example.com').status=waiting"
    puppetca.example.com
