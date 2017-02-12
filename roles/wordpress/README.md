# はじめに

CentOS 7.3 に WordPress-4.7.2（2017/02/12現在）+ ワンタイムパスワード(OTP)用プラグインを導入するための Ansible Playbook です。

# ベース構築手順（ローカル環境）

Vagrant + VirtualBox の環境で動作を確認しています。Vagrant-1.9.1 には CentOS 7.x で private_network を使う際に IP アドレスが有効にならないというバグがあるので、この構成を使う場合は１つ前の Vangrant-1.9.0 にしておくのが無難です。

Vagrant + VirtualBox 上で WordPress を動かす環境の構築方法は[リポジトリのトップページ](https://github.com/hotta/ansible-centos7) の Prerequisite を参照してください。

手順の中で、vagrant init すると Vagrantfile が作られますので、以下のように変更しています。

```Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/centos-7.3"
  config.vm.hostname = "wp.local"
  config.vm.network "private_network", ip: "192.168.56.2", auto_config: "false"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "1024"
  end
  
  config.vm.provision "shell", inline: <<-SHELL
    sudo yum -y install epel-release git
    sudo yum -y install ansible
  SHELL
end
```
192.168.56.2 は、VM に割り当てたい IP アドレスを指定します。private_network 配下でこのアドレスが未使用であれば、そのままで構いません。

# ベース環境構築手順（本番環境）

EC2 で動作確認中です。ansible でインスタンスを建てるところはまだできていないので、他の手順（AWS コンソールや AWS CLI 等）で CentOS 7.x のインスタンスを作成し、Vagrantfile のプロビジョニングスクリプト部分で記載しているコマンド２つ(yum install)は手作業で実行しました。

# WordPress 環境構築手順

以下の手順で実行します。

```bash
$ git clone https://github.com/hotta/ansible-centos7.git
$ sudo rm -r /etc/ansible
$ sudo mv ansible-centos7 /etc/ansible
$ cd /etc/ansible/
$ cp hosts.example hosts
$ vi hosts (You may want to make some changes.)
$ cd host_vars
$ cp localhost.yml.tmpl localhost.yml
$ vi localhost.yml  (You may want to make some changes.)
$ cd
$ ansible-playbook /etc/ansible/jobs/wordpress.yml
```

途中で設定ファイルを編集するところがありますが、以下のようにしました。

## hosts

ansible で管理する対象のホストを記載します。VM の中に ansible を導入し、自分自身 (localhost) を変更することを前提としていますので、特に変更した箇所はありません。

## localhost.yml

- MY_IP_ADDRESS - VM に割り当てた IP を指定します。セルフテストに便利なように、単に /etc/hosts に自ホストのエントリを追加するためだけに使っています。
- WP_XXXX - 本番環境で使う場合は、環境に合うように適切に設定してください。特にパスワードはきちんと設定してください。ローカル環境の場合はそのままでも構わないでしょう。

## 動作確認と OTP 設定

操作しているパソコンの hosts ファイルに wordpress 仮想ホストのエントリ（ここではwordpress.local とします）を追加するか、DNS に登録して、名前で WordPress にアクセスできるようにします。

http://wordpress.local にアクセスすると、トップページが表示されます。

http://wordpress.local/wp-admin/ にアクセスすると、管理ページが表示されます。

![Screenshot](https://github.com/hotta/images/blob/master/wp-login.png?raw=true) 

最初から OTP が有効になっていますが、初回は localhost.yml に設定した WP_ADMIN_USER と WP_ADMINPASS のみを入力してログインします。管理者でログイン後、右上の「こんにちは XXX さん」メニューから「プロフィールを編集」を選択します。

![Screenshot](https://github.com/hotta/images/blob/master/wp-otp-set.PNG?raw=true)

ページの中ほどに OTP の設定箇所が出てきます。スマホに OTP 認証アプリを入れていない場合は、画面の指示に従ってアプリを入れてください。その後、画面に表示された QR コードをアプリで読み込むと、アプリにその WordPress のサイトが登録されます。アプリに表示された6桁のワンタイムパスワードを画面に入力し、「プロフィールの保存」をすれば OTP が有効になります。OTP の有効／無効はログインユーザーごとに設定可能ですが、まぁこのご時世ですので、OTP は必須だと割り切った方がいいと思います。
