# はじめに

CentOS 7.3 に WordPress-4.7.2（2017/02/12現在）+ ワンタイムパスワード用プラグインを導入するための Ansible Playbook です。

# ベース構築手順（ローカル環境）

Vagrant + VirtualBox の環境で動作を確認しています。Vagrant-1.9.1 には CentOS 7.x で private_network に IP アドレスが有効にならないというバグがあるので、この構成を使う場合は１つ前の Vangrant-1.9.0 にしておくのが無難です。

Vagrant + VirtualBox 上で WordPress を動かす環境の構築方法は[リポジトリのトップページ](https://github.com/hotta/ansible-centos7) の Prerequisite を参照してください。

手順の中で、vagrant init すると Vagrantfile が作られますので、以下のように変更しています。

```Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"
  config.vm.hostname = "wp.local"
  config.vm.network "private_network", ip: "192.168.56.4", auto_config: "false"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y install epel-release git
    sudo yum -y install ansible
  SHELL
end
```
192.168.56.4 は、VM に割り当てたい IP アドレスを指定します。このアドレスが未使用であれば、そのままで構いません。

# ベース環境構築手順（本番環境）

EC2 で動作確認中です。CentOS 7.x のインスタンスを作成し、Vagrantfile 中のプロビジョニングスクリプトの部分（２行）を手で実行しました。

# WordPress 環境構築手順

トップページのクイックスタートの部分を実行します。途中で設定ファイルを編集するところがありますが、以下のようにしました。

## hosts

ansible で管理する対象のホストを記載します。VM の中に ansible を導入し、自分自身 (localhost) を変更することを前提としていますので、特に変更した箇所はありません。

## localhost.yml

- MY_IP_ADDRESS - VM に割り当てた IP を指定します。セルフテストに便利なように、単に /etc/hosts に自ホストのエントリを追加するためだけに使っています。
- WP_XXXX - 本番環境で使う場合は、環境に合うように適切に設定してください。特にパスワードはきちんと設定します。ローカル環境の場合はそのままでも構わないでしょう。

なおこの手順では、最後の行で Laravel を入れていますが、この行は不要です。その代わり、以下のコマンドを投入します。

```bash
$ ansible-playbook /etc/ansible/jobs/wordpress.yml
```

## 動作確認

操作しているパソコンの hosts ファイルに wordpress 仮想ホストのエントリ（ここではwordpress.local とします）を追加するか、DNS に登録して、名前で WordPress にアクセスできるようにします。

http://wordpress.local にアクセスすると、トップページが表示されます。

http://wordpress.local/wp-admin/ にアクセスすると、管理ページが表示されます。

