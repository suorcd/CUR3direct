Role Name
=========

A role that accepts variables and created corresponding NGINX conf

Requirements
------------

An up-to-date Ubuntu Jammy install

Role Variables
--------------

dn_source: Domain Name Source (string)
dn_destination: Domain Name Destination (string)
redirect_code: HTTP redirect code;usually 301 (int)
tls: TLS enable or disabled (boolean)
ipv6: enable IPv6 (boolean)

Dependencies
------------

curry_nginx

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: username.rolename, x: 42 }
    - hosts: servers
      roles:
        - role: curry_redirect
          dn_source: newpodcastapps.com
          dn_destination: https://podcastindex.org:443/apps
          redirect_code: 301
          tls: false
          ipv6: false
License
-------

GPL-2.0-or-later

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
