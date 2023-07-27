string1="fname=sandeep" 
string2="topic=linux"
string3="deepak"
string4="Hello"

string5="abcdeepakabcxyz"

echo "${string5#a*c}"
echo "${string5%a*z}"

echo "${string4}"**"${string3}"
echo "${string1%%=s*p}"
echo "${string1%%=*}"

echo "${string1#f*e=}"
echo "${string1#*=}"