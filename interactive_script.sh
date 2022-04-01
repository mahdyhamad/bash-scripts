#!/bin/bash
# chmod a+rx helloWorld.sh 

# The script should have three main functionalities:

if [ $# -eq 0 ]
then
    echo "Usage: $0 <directory>"
    exit 1
elif [ $# -eq 3 ]
then
    if [ -d $1 ]
    then
        echo "changing directory to $1"
        cd $1

        if [ $2 = 'ana' ]
        then
            # "ana" which means analytics, then followed by the regex that you are going to count.
            if [[ -f $1 ]]; then
                WORLD_COUNT=$(egrep $3 $FILE -o -s| wc -l)
                echo "The number of $3 in $FILE is $WORLD_COUNT"
            elif [[ -d $1 ]]; then
                for FILE in *;
                do  
                    if [[ -f $FILE ]]; then
                        WORLD_COUNT=$(egrep $3 $FILE -o -s | sort | uniq | wc -l)
                        echo "The number of $3 in $FILE is $WORLD_COUNT"
                    fi
                done
            fi
        elif [ $2 = 'del' ]
        then
            # "del" which means delete, followed by the biggest file size. Files larger than that should be deleted.
            for FILE in *; 
            do
                # TODO: add interactive delete if interactive mode is on.
                if [[ -f $FILE ]]; then
                    FILE_SIZE=$(wc -c $FILE | awk '{print $1}')
                    if [ FILE_SIZE -gt $3 ]
                    then
                        echo "Deleting $FILE"
                        rm $FILE
                    fi
                fi
            done
        elif [ $2 = 'arr' ]
        then
            # "arr" which means arrange, followd by the file type you are going to arrange in one new directory.
            echo "creating new..."
            mkdir "arrange-$3-files"
            echo "coppying files..."
            cp *$3 "arrange-$3-files"
            
        else
            echo "Usage: $0 <directory> <ana|del|arr>"
            exit 1
        fi
    else
        echo "$1 is not a directory"
        exit 1
    fi
else
    echo "Usage: $0 <directory> <ana|del|arr>"
    exit 1
fi

