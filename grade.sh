CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

File=./student-submission/ListExamples.java
if [[ ! -f "$File" ]]; 
then 
    echo 'File does not exist. Must be ListExamples.java' 
    exit
fi 

cp ./lib/*.jar ./student-submission/* ./TestListExamples.java ./grading-area
cp -r ./lib ./grading-area

cd ./grading-area
javac -cp ".;..\lib\junit-4.13.2.jar;..\lib\hamcrest-1.3.jar" *.java  2>failed.txt

if [[ -s failed.txt ]]
then 
    cat failed.txt
    exit
else 
    echo "Compile successful. Hooray"
fi

java -cp ".;..\lib\junit-4.13.2.jar;..\lib\hamcrest-1.3.jar" org.junit.runner.JUnitCore TestListExamples.java > results.txt
tail -n 2 results.txt > score0.txt
grep  -o --regexp='[0-9]*' score0.txt > score1.txt
head -n -3 results.txt
echo Number of Failures: head -n 2 score1.txt | tail -n 1 score1.txt
echo Total number of tests: head -n 1 score1.txt