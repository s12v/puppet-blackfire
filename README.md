Puppet module for installing, configuring and managing [Blackfire PHP profiler](https://blackfire.io/).

[![Build Status](https://travis-ci.org/s12v/puppet-blackfire.svg?branch=master)](https://travis-ci.org/s12v/puppet-blackfire)

# blackfire

## Support

This module is currently tested on:

 - Ubuntu 14.04
 - Ubuntu 12.04
 - Ubuntu 10.04
 - Centos 7.0
 - Centos 6.6
 - Debian 7.8

It may work on other distros.

## Setup

The module includes a single public class `blackfire`.
You need to provide at least `server_id` and `server_token` parameters, therefore minimum configuration looks like this:
```puppet
class { 'blackfire':
	server_id    => 'b54114a9-df8a-563b-8ba3-e5457155010e',
	server_token => '7315b1cf617bf51575ba463e813156ed97c85d8ca5c5691db37bbfe36a622a4f'
}
```

If you want to provide additional parameters to Agent or PHP extension:
```puppet
class { 'blackfire':
	server_id    => 'b54114a9-df8a-563b-8ba3-e5457155010e',
	server_token => '7315b1cf617bf51575ba463e813156ed97c85d8ca5c5691db37bbfe36a622a4f',
	agent => {
		log_level => 2
	},
	php => {
		log_level => 3
	}
}
```

## Reference

### Classes

#### Public classes

 - `blackfire`: Main class

#### Private classes
 - `blackfire::repo`: Handles the repository.
 - `blackfire::agent`: Manages the Agent
 - `blackfire::agent::install`: Handles the packages.
 - `blackfire::agent::config`: Handles the configuration file.
 - `blackfire::agent::service`: Handles the service.
 - `blackfire::php`: Manages the PHP extension (Probe)
 - `blackfire::php::install`: Handles the packages.
 - `blackfire::php::config`: Handles the configuration file.

### Parameters

#### Available parameters for blackfire class

 - `manage_repo` - Manage Blackfire repository. Default is *true*
 - `server_id` - Server ID to use for the agent (See https://blackfire.io/account/credentials)
 - `server_token` - Server Token to use for the agent (See https://blackfire.io/account/credentials)
 - `agent` - Configuration for Blackfire Agent
   - `manage` - Manage Agent. Default is *true*
   - `manage_service` - Manage Agent service. Default is *true*
   - `service_ensure` - Default is *running*
   - `version` - Which version of the agent to install. Default is *latest*
   - `log_file` - The path of the log file. Use "stderr" to log to stderr. Default is *stderr*
   - `log_level` - Log verbosity level (4: debug, 3: info, 2: warning, 1: error). Default is *1*
   - `socket` - The socket the agent will listen to. Default is *unix:///var/run/blackfire/agent.sock*
   - `http_proxy` - Http proxy to use
   - `https_proxy` - Https proxy to use
   - `ca_cert` - PEM encoded certicates
   - `collector` - URL of Blackfire's data collector. Default is *https://blackfire.io*
   - `spec` - The path to the json specifications file
 - `php` - Configuration for Blackfire PHP extension
   - `manage` - Manage PHP extension. Default is *true*
   - `version` - Which version of the probe to install. Default is *latest*
   - `log_file` - The path of the log file.
   - `log_level` - Log verbosity level (4: debug, 3: info, 2: warning, 1: error). Default is *1*
   - `agent_socket` - The agent socket. Default is *unix:///var/run/blackfire/agent.sock*
   - `agent_timeout` - The agent timeout. Default *0.25*

## Module testing

 - `bundle exec rake metadata` - Validate metadata.json file
 - `bundle exec rake syntax` - Syntax check Puppet manifests and templates 
 - `bundle exec rake lint` - Check puppet manifests with puppet-lint / Run puppet-lint
 - `bundle exec rake spec` - Run spec tests in a clean fixtures directory

### Acceptance testing with beaker

 - `bundle exec rake beaker_nodes` - List available beaker nodesets
 - `BLACKFIRE_SERVER_ID=... BLACKFIRE_SERVER_TOKEN=... bundle exec rake beaker` - Run beaker acceptance tests (default nodeset)
 - `BEAKER_set=centos-70-x64 BLACKFIRE_SERVER_ID=... BLACKFIRE_SERVER_TOKEN=... bundle exec rake beaker` - Run beaker acceptance tests for the nodeset
