alias find.swp="find . -name *.swp"
alias find.swp.rm="find . -name *.swp | xargs rm"

# remove everything but using find
#find . ! -name 'file.txt' -type f -exec rm -f {} +
#find . -type f -not -name '*.gz'-delete
#find . -type f -not -name '*gz' -print0 | xargs -0  -I {} rm -v {}
