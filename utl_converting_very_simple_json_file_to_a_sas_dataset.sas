Converting very simple json file to a sas dataset

WS/PROC R solution

RJSONIO can do much more complex JSON files.


INPUT
=====

[
{
  "id": "0a3f50a4-dea6-32b8-e044-0003ba298018",
  "status": 1,
  "vejkode": "1723",
  "vejnavn": "**bleep**otvej",
  "adresseringsvejnavn": "**bleep**otvej",
  "husnr": "70",
  "etage": null,
  "dÃ¸r": null,
  "supplerendebynavn": null,
  "postnr": "2730",
  "postnrnavn": "Herlev",
  "kommunekode": "0163",
  "adgangsadresseid": "0a3f507c-788b-32b8-e044-0003ba298018",
  "x": 12.43946822,
  "y": 55.7150554
}
]


WORKING CODE
============

    jsn <- as.data.frame(fromJSON("d:/json/have.json", collapse="",nullValue=NA));
    jsnxpo<-cbind(names(jsn),t(jsn));

OUTPUT
======

 WORK.WANT  total obs=15

  V1                     V2

  id                     0a3f50a4-dea6-32b8-e044-0003ba298018
  status                 1
  vejkode                1723
  vejnavn                **bleep**otvej
  adresseringsvejnavn    **bleep**otvej
  husnr                  70
  etage
  dÃ.r
  supplerendebynavn
  postnr                 2730
  postnrnavn             Herlev
  kommunekode            0163
  adgangsadresseid       0a3f507c-788b-32b8-e044-0003ba298018
  x                      12.43947
  y                      55.71506

*                _              _       _
 _ __ ___   __ _| | _____    __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \  / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/ | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|  \__,_|\__,_|\__\__,_|

;
data _null_;
 file "d:/json/have.json";
 input;
 put _infile_;
 putlog _infile_;
cards4;
[
{
  "id": "0a3f50a4-dea6-32b8-e044-0003ba298018",
  "status": 1,
  "vejkode": "1723",
  "vejnavn": "**bleep**otvej",
  "adresseringsvejnavn": "**bleep**otvej",
  "husnr": "70",
  "etage": null,
  "dÃ¸r": null,
  "supplerendebynavn": null,
  "postnr": "2730",
  "postnrnavn": "Herlev",
  "kommunekode": "0163",
  "adgangsadresseid": "0a3f507c-788b-32b8-e044-0003ba298018",
  "x": 12.43946822,
  "y": 55.7150554
}
]
;;;;
run;quit;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;
%utl_submit_wps64(resolve('
options set=R_HOME "C:/Program Files/R/R-3.3.2";
libname wrk "%sysfunc(pathname(work))";
proc r;
submit;
library("RJSONIO");
jsn <- as.data.frame(fromJSON("d:/json/have.json", collapse="",nullValue=NA));
jsnxpo<-cbind(names(jsn),t(jsn));
endsubmit;
import r=jsnxpo data=wrk.want;
run;quit;
'));

