# test_case_dev_ROR

A simple rails banking app.

- [x] Via the console you can create users with password.
- [x] Users are able to log in.
- [x] Via the console you can give the user credit.
- [x] Users have bank accounts with balance.
- [x] Users can transfer money to each other.
- [x] Users may not have a negative balance on their account.
- [x] It is traceable how a user obtained a certain balance.
- [x] Money cannot disappear or appear into account.

What could be done better if I would have more time:

- UUID is an easy way to generate unique numbers for bank accounts, but in real life we usually use more readable and shorter numbers for bank accounts. So maybe it would be better to switch to some other way to generate numbers for bank accounts.
- Better store any text in locales instead of hardcoding them.
- Need to validate also the edge case when sending bank account and receiving bank account are the same, as there is no sense in such an operation.
- Instead of validating with model validations it would be better to validate explicitly before that to return more sensible errors
- We should catch errors inside our transaction to return some notifications instead of 500. 
