
## Gitbook Docker Image

Install latest versions of Gitbook toolchain onto the node:slim base image


## Usage

I've included a Makefile with targets to the commonly used Gitbook commands

## Example

```
# Create a new gitbook environment
mkdir mybook
cd mybook
cp ../gitbook/Makefile .
make init

# Start the internal server. View in browser at http://localhost:4000
make serve
# hack, hack ... hack
make stop

# Create all outputs
make

# Or just create specific outputs
make html
```