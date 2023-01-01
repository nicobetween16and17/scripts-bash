$namefile= $1.hpp
echo "#ifndef $1_hpp" > $namefile
echo "#define $1_hpp" >> $namefile

echo "#include <iostream>" >> $namefile
echo "using namespace std;" >> $namefile

echo " " >> $namefile



echo "class $1 {" >> $namefile

echo " " >> $namefile


printf "    private: \n" >> $namefile
c=1
for i in "${@:2}"; do
    if [ $((c%2)) -eq 0 ]
    then
        echo "$i;" >> $namefile
    else
        printf "        $i " >> $namefile
    fi
    c=$((c+1))
done
echo " " >> $1.h

printf "    public: \n" >> $namefile

printf "        $1(); \n" >> $namefile

for i in "${@:2}"; do
    if [ $((c%2)) -eq 0 ]
    then

        echo "$i(); " >> $namefile
    else

        printf "    $i get_" >> $namefile
    fi
    c=$((c+1))
done
prev=""

for i in "${@:2}"; do
    if [ $((c%2)) -eq 0 ]
    then
        printf "        void set_$i($prev); \n" >> $namefile

    else

        prev=$i

    fi
    c=$((c+1))
done

printf "        void to_string(); \n" >> $namefile

echo "}; " >> $namefile

echo " " >> $namefile


echo "$1::$1() {" >> $namefile
for i in "${@:2}"; do
    if [ $((c%2)) -eq 0 ]
    then
        printf "    $i= 0; \n" >> $namefile
    fi
    c=$((c+1))
done

echo "}" >> $namefile

echo " " >> $namefile

for i in "${@:2}"; do
    if [ $((c%2)) -eq 0 ]
    then
        echo "$prev $1::get_$i() { return $i; }" >> $namefile


    else

        prev=$i
    fi
    c=$((c+1))
done

echo " " >> $namefile

for i in "${@:2}"; do
    if [ $((c%2)) -eq 0 ]
    then
        echo "void $1::set_$i($prev new_$i) { $i= new_$i; }" >> $namefile

    else

        prev=$i
    fi
    c=$((c+1))
done

echo " " >> $1.h

echo "void $1::to_string() {" >> $namefile

for i in "${@:2}"; do
    if [ $((c%2)) -eq 0 ]
    then
        echo "  cout << \"$i\" << $i << endl; " >> $namefile
    fi
    c=$((c+1))
done

echo "}" >> $namefile

echo " " >> $namefile

echo "#endif" >> $namefile