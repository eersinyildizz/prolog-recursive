/** Ersin Yıldız - 200201010 */
/* Question 2 */
/* Açıklamalar:*/
/* Sistemi çalıştırmak için al([0,0,0,0,1,1,1,1,1],[]) girdisini veriyoruz. İlk girilen list soruda verilen 4 sıfır ve 5 bir dir.*/
/* 2.list ise boş listedir. Yeni üretilen liste bu boş liste kullanılarak oluşturuluyor.*/
/* promram çalıştırılınca "out of local stack" hatası alıncaya kadar yeni liste üretmeye devam ediyor. Bu da bu işlemler */
/* sırasında hiçbir zaman 0 0 0 0 0 0 0 0 0 değerini ulaşmadığını gösteriyor. Eğer ulaşsaydı prove fonksiyonunda false değeri dönecekti */

/* baks => listede kaç adet 0 olduğunu buluyor.*/
baks([],0).
baks([0|T],S):- baks(T,N), S is N+1.
baks([1|T],S):- baks(T,N), S is N.

/* bakb => listede kaç adet 1 olduğunu buluyor.*/
bakb([],0).
bakb([1|T],B):- bakb(T,M), B is M+1.
bakb([0|T],B):- bakb(T,M), B is M.

/* İLk girdiğimiz listede 4 tane 0,  5 tane 1 olduğunu kontrol ediyor.*/
als(X):- baks(X,S), 4 is S.
alb(X):- bakb(X,B), 5 is B.

/* Yeni listeye veri eklemek için */ 
append([],X,X).                            
append([X|Y],Z,[X|W]) :- append(Y,Z,W).  

/* Listenin ilk elemanı ile son elemanını kıyaslıyor. G ilk eklenen 8 elaman bulunuyor. Daha sonrasında listenin ilk ve son */
/* son elemanın bularak kıyaslama yapıyorum. Eğer aynı ise G listeme 0 ekliyor değilde 1 ekliyor. Son al fonk ile yeni listeyi*/
/* en baştan kontrol ediyor.*/ 
compare_adj([First|Rest],G) :- compare_adj([First|Rest], First,G).
compare_adj([_,B|T], F,G) :-compare_adj([B|T], F,G).
compare_adj([Last], First,G) :- Last = First, append([0],G,M),printlist(M),al(M,[]); append([1],G,M),printlist(M),al(M,[]).
 
/* Prove yapılan kısım burasıdır. İLk girilen ve daha sonrasında oluturulan listede 0 ve 1 sayısının sayıları eğer 0 dan büyükse*/
/* sistem hiçbir zaman 0 0 0 0 0 0 0 0 0 yada 1 1 1 1 1 1 1 1 1 üretemez. Buda bizden istenen prove sağlar. */
prove(X):-baks(X,P), P > 0, bakb(X,O), O > 0.

/*Listenin bitip bitmediğini kontrol ediyor. Bittiyse ilk ve son elemanı kıyaslamak için compare_adj fonk. gidiyor. */
coz(_,[],G,E):- compare_adj(E,G).

/* Burada listedeki elemanlar yanyana olanlar tek tek kontrol edilip aynıysa 0 değilse 1 değer yeni listeye her bir adım için */
/* tek tek ekleniyor.*/
coz(X,[Z|Y],L,E):- X = Z,append([0],L,G), coz(Z,Y,G,E); append([1],L,G), coz(Z,Y,G,E).

/* Yeni oluşturulan listeleri yazdırıyor.*/
 printlist([]).
 printlist([X|List]) :-
 write(X),write(" "),
 printlist(List),nl.

 /* listenin head ve tail ayırıp coz fonk gönderiyor. */
gir([H|T],L,X):-coz(H,T,L,X).

/* Program başlatılıdığın ilk çalışan ksımdır. İlk prove değerini kontrol ediyor, daha sonra yeni liste üretimi adımlarını yapıyor. */
al(X,L):-prove(X), gir(X,L,X).