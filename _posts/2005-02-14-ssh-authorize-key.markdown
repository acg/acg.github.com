---
layout: post
title: "SSH Pubkey Setup In One Command"
root: ../../..
---

Transfer your ssh public key to a remote host, for passwordless logins, in one command:

{% highlight bash %}
ssh < "$key" "$@" '
  cat > $HOME/authorized_keys && 
  mkdir -p .ssh &&
  cat $HOME/authorized_keys >> $HOME/.ssh/authorized_keys &&
  rm -f $HOME/authorized_keys &&
  chmod 0700 .ssh &&
  chmod 0600 $HOME/.ssh/authorized_keys'
{% endhighlight %}

Note that newer versions of ssh now have `ssh-copy-id(1)`.

