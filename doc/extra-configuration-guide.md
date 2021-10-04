# Extra configuration

Here are some snippets for extra configuration.

## Git configuration

```shell
ssh-keygen -t rsa -C "datwaftx@gmail.com"
xclip < ~/.ssh/id_rsa.pub
```

Paste your *ssh* public key into your *github* account settings.
Go to your *github* Account Settings
Click “SSH Keys” on the left.
Click “Add SSH Key” on the right.
Add a label (like “WSL”) and paste the public key into the big text box.

In a terminal/shell, type the following to test it:

```shell
ssh -T git@github.com
```
