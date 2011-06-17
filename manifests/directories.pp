# Removal of these directories should be done manually.

define sedue::directories($user, $instance) {
  # repos/${instance} is created by backend DB(e.g. MongoDB's puppet)

  sedue::directory { "sedue::${instance}_directory_arc_dir":
    user => $user,
    instance => $instance,
    category => 'arc-dir'
  }

  sedue::directory { "sedue::${instance}_directory_tmp":
    user => $user,
    instance => $instance,
    category => 'tmp'
  }

  sedue::directory { "sedue::${instance}_directory_indexing":
    user => $user,
    instance => $instance,
    category => 'indexing'
  }

  sedue::directory { "sedue::${instance}_directory_export":
    user => $user,
    instance => $instance,
    category => 'export'
  }

  sedue::directory { "sedue::${instance}_directory_log":
    user => $user,
    instance => $instance,
    category => 'log'
  }

  sedue::directory { "sedue::${instance}_directory_append_log":
    user => $user,
    instance => $instance,
    category => 'append-log'
  }

  sedue::directory { "sedue::${instance}_directory_assist_arc_dir":
    user => $user,
    instance => $instance,
    category => 'assist-arc-dir'
  }
}
