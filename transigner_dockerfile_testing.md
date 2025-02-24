# Testing the transigner dockerfile to verify if it is functioning correctly

All tests will use the local data in `test_data` 

1) easy.sh testing 
```bash
docker run -v /home/my_dir/out:/out number25/transigner:1.1.3 easy.sh -a 2 -e 1 -d ont_drna -m default ./test_data/test.fq.gz ./test_data/hg38_mrna+lncrna.fa.gz /out
```
Output is correct as expected.

2) transigner align testing 
```bash
docker run -v /home/my_dir/out:/out number25/transigner:1.1.3 transigner align -q ./test_data/test.fq.gz -t ./test_data/hg38_mrna+lncrna.fa.gz -d /out -p 2
```

3) transigner pre testing 
```bash
docker run -v /home/number25/local_analysis/transigner_new/transigner/out:/out number25/transigner:1.1.3 transigner pre -i /out/temp.bam -d /out
```

4) transigner em testing
```bash
docker run -v /home/number25/local_analysis/transigner_new/transigner/out:/out number25/transigner:1.1.3 transigner em -s /out/scores.csv -d /out -u /out/unmapped.txt -m /out/tmap.csv -dtype ont_drna -p 1
```

Tested across all "modes" and datatypes following options presented in `easy.sh`
