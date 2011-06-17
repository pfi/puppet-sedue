# Removal of these directories should be done manually.

define sedue::directories($user, $instance) {
  # repos/${instance} is created by backend DB(e.g. MongoDB's puppet)

  sedue::directory { "sedue::${instance}_directory_arc_dir":
    user => $user,
    instance => $instance,
    name => 'arc-dir'
  }

  sedue::directory { "sedue::${instance}_directory_tmp":
    user => $user,
    instance => $instance,
    name => 'tmp'
  }

  sedue::directory { "sedue::${instance}_directory_indexing":
    user => $user,
    instance => $instance,
    name => 'indexing'
  }

  sedue::directory { "sedue::${instance}_directory_export":
    user => $user,
    instance => $instance,
    name => 'export'
  }

  sedue::directory { "sedue::${instance}_directory_log":
    user => $user,
    instance => $instance,
    name => 'log'
  }

  sedue::directory { "sedue::${instance}_directory_append_log":
    user => $user,
    instance => $instance,
    name => 'append-log'
  }

  sedue::directory { "sedue::${instance}_directory_assist_arc_dir":
    user => $user,
    instance => $instance,
    name => 'assist-arc-dir'
  }
}
