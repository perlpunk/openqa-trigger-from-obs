cd "$(dirname "${BASH_SOURCE[0]}")"

(
dockerfail=0
cd docker
for t in *.sh; do
    [ -x "$t" ] || continue
    for i in $(seq 1 3); do
        ./$t && s=0 && break || s=$? && sleep 10;
    done
    if [ $? -eq 0 ] ; then
        echo "P:$t"
    else
        : $((dockerfail++))
        echo "F-$t"
    fi
done
exit $dockerfail
)
dockerfail=$?
( exit $dockerfail )
