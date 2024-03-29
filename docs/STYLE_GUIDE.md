<!-- markdownlint-configure-file
{
  "line-length": {
    "line_length": 80,
    "heading_line_length":80,
    "code_block_line_length":300,
    "headings":80,
    "code_blocks": true
  },
  "hr-style": {
    "style": "consistent"
  },
  "header-style": {
    "style": "setext_with_atx"
  },
  "required-headings": {
    "headings": [
      "# Ansible Style Guide",
      "## General",
      "## Formatting",
      "*",
      "## Playbooks",
      "*",
      "## Organization",
      "*",
      "### Roles",
      "*",
      "### Tasks",
      "*"
    ]
  }
}
-->

Ansible Style Guide
===================

This document is intended to be a superset of the
[Ansible Best Practices](http://docs.ansible.com/playbooks_best_practices.html)
document.

General
-------

* Variables should use underscores, rather than hyphens or camelCase.
  Use `foo_bar`, not `foo-bar` or `fooBar`
* Where possible, prefer roles over tasks or included tasks. However…
* Developing new plays/playbooks might initially be done in a single monolithic
  playbook to more rapidly iterate. But use existing roles where possible.
* Playbooks should be as idempotent as possible.
* Prefer Ansible modules to `command` or `shell`.

Formatting
----------

Use YAML continuation syntax to break long lines.

Correct:

```ansible
- name: setup logrotate script
  copy: >
    src=files/mongodb.logrotate
    dest=/etc/logrotate.d/mongodb
    owner=root
    group=root
    mode=0644
```

Incorrect:

```ansible
- name: setup logrotate script
  copy: src=files/mongodb.logrotate dest=/etc/logrotate.d/mongodb owner=root group=root mode=0644
```

Use spaces when interpolating variables.

Correct:

```Jinja2
{{ foo }}
```

Incorrect:

```Jinja2
{{foo}}
```

Playbooks
---------

Playbooks that include orchestration should also have a companion playbook that
only does remediation. This allows plays to be run against existing instances.
For example: `create-and-localize-redis.yml` might have the corresponding
`localize-redis.yml` playbook that can be run against all existing redis
instances.

Organization
------------

### Roles

Where possible, prefer roles over included tasks. This encourages code re-use.

### Tasks

* It is not necessary name your tasks if it's clear what they do. Bear in mind
  this will omit a descriptor when the play is run.
