{{ salt['runtests_helpers.get_sys_temp_dir_for_path']('issue-1959-virtualenv-runas') }}:
  virtualenv.manage:
    - requirements: salt://issue-1959-virtualenv-runas/requirements.txt
    - runas: issue-1959
