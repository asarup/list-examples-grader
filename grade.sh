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

file='./student-submission/ListExamples.java'
if [[ ! -f "$file" ]]
then
    echo 'Missing file: ListExamples.java'
    exit
fi

cp ./TestListExamples.java ./student-submission/* ./grading-area
cp -r ./lib ./grading-area

cd ./grading-area

javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 2>compileerr.txt
if [[ -s compileerr.txt ]]
then
    echo 'The submitted ListExamples.java file did not compile. The error can be seen below:'
    cat compileerr.txt
    exit
else
    echo 'Submission compiled successfully!'
fi

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples 1>results.txt

cat results.txt