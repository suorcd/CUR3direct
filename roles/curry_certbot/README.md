Role Name
=========

Create certs based off of variables; assuming you own the domain.

Requirements
------------

An up-to-date Ubuntu Jammy install

Role Variables
--------------

cert_domain - Is the domain you wish to request a Let's Encrypt cert for

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
        - role: curry_certbot
          cert_domain: newpodcastapps.com
License
-------

GPL-2.0-or-later

Author Information
------------------

An optional section for the role authors to include contact information, or a website (HTML is not allowed).
