Vault has support for using GCP (or, as the case may end up being, AWS, depending on pricing) KMS for the master encryption bits.
It also has support for Google Cloud Storage and S3 backends for actually storing the secret data.
Between the two of those, I can run a vault instance anywhere I can give it credentials to access those backend bits.

So this is:
* write some terraform what sets up cloud KMS and storage resources.
* write a `docker-compose.yaml` file that starts up vault locally, configured with the backend.
* write a script that will sign my SSH certificate using the locally running vault instance.

Future fun bits:
* lock down the aws/gcp things to proper service accounts yadda yadda.
  Something like AWS's AssumeRole that my user can assume, but with GCP.
  For this Project.
* Get my iOS SSH client of currently of choice, Blink, able to support SSH certificates.

