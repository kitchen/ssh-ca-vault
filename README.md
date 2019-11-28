Greetings!

I am moving this whole shebang into gcloud over at https://github.com/kitchen/personal-terraform/ so this is no longer going to be updated. But I'll leave it up here anyways :)



# old stuff
Greetings!

I'm getting awfully tired of having to update-the-world every time I get a new machine (and therefore ssh key).
So I'm finally going to dive into the wonderful world of SSH CA.
My previous experiment didn't go so well for some reason, and I also though it needed to be configured at the `/etc/ssh` level, not just `~/.ssh/authorized_keys`, but now I know better, and I have a proof of concept working!

So now I just need to figure out the "how do I even CA, bro?", and for that I'm choosing to use Hashicorp's wonderful Vault tool, which can act as an SSH certificate authority!
Woo!

But, how do I run it?
How do I interact with it?
Where do all the master secrets and such live?
What is the meaning of life?
Well, I can at least answer a few of those questions.

Vault has support for using GCP (or, as the case may end up being, AWS, depending on pricing) KMS for the master encryption bits.
It also has support for Google Cloud Storage and S3 backends for actually storing the secret data.
So between the two of those, I should be able to run a Vault instance anywhere I can give it credentials to access those backend bits.

So the plan is:
* write some terraform what sets up cloud KMS and storage resources
* write a `docker-compose.yaml` file that starts up vault locally, configured with the backend.
* write a script that will sign my SSH certificate using the locally running vault instance.

Future fun bits:
* lock down the aws/gcp things to proper service accounts yadda yadda.
  Something like AWS's AssumeRole that my user can assume, but with GCP.
  For this Project.
* Get my iOS SSH client of currently of choice, Blink, able to support SSH certificates.
* something something ssh key into the secure enclave of my laptop? Mayyyyybe? :D I am fairly certain this is possible, but it appears to be a bit on the hacky side, similar to using PGP and a Yubikey for it.

Anywho, this should be a fun little weekend project.
