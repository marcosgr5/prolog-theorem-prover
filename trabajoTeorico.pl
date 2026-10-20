%% ========================
%% Definimos los operadores
%% ========================
:- op(200, fy,  ~).
:- op(500, xfy, /\).
:- op(600, xfy, \/).
:- op(700, xfy, =>).

%% =========================
%% 1. Eliminar implicaciones
%% =========================
rmImpl(P=>Q, ~P1 \/ Q1):- !, rmImpl(P,P1), rmImpl(Q,Q1).
rmImpl(P/\Q, P1 /\ Q1):- !, rmImpl(P,P1), rmImpl(Q,Q1).
rmImpl(P\/Q, P1 \/ Q1):- !, rmImpl(P,P1), rmImpl(Q,Q1).
rmImpl(~P, ~P1):- !, rmImpl(P,P1).
rmImpl(P, P).

%% =========================
%% 2. Forma Normal Negativa (NNF)  ← CORREGIDO
%% =========================
simNeg(~(~P), P1):- !, simNeg(P, P1).
simNeg(~(P\/Q), P1 /\ Q1):- !, simNeg(~P, P1), simNeg(~Q, Q1).  % De Morgan
simNeg(~(P/\Q), P1 \/ Q1):- !, simNeg(~P, P1), simNeg(~Q, Q1).  % De Morgan
simNeg(P/\Q, P1 /\ Q1):- !, simNeg(P, P1),  simNeg(Q, Q1).
simNeg(P\/Q, P1 \/ Q1):- !, simNeg(P, P1),  simNeg(Q, Q1).
simNeg(P, P).

%% =========================
%% 3. Distribuir OR sobre AND → FNC  ← CORREGIDO
%% =========================
dist(P\/(Q/\R), (P1\/Q1) /\ (P2\/R1)):- !, dist(P,P1), dist(P,P2), dist(Q,Q1), dist(R,R1).
dist((P/\Q)\/R, (P1\/R1) /\ (Q1\/R2)):- !, dist(P,P1), dist(Q,Q1), dist(R,R1), dist(R,R2).
dist(P/\Q, P1/\Q1) :- !, dist(P,P1), dist(Q,Q1).
dist(P\/Q, P1\/Q1) :- !, dist(P,P1), dist(Q,Q1).
dist(P, P).

fnc(F, FNF) :-
    dist(F, F1),
    (F == F1 -> FNF = F1 ; fnc(F1, FNF)).

%% =========================
%% 4. Extraer cláusulas
%% =========================
clausulas(P/\Q, L) :- !,
    clausulas(P, L1),
    clausulas(Q, L2),
    append(L1, L2, L).
clausulas(P, [C]) :-
    literales(P, C).

literales(P\/Q, L) :- !,
    literales(P, L1),
    literales(Q, L2),
    append(L1, L2, L).
literales(P, [P]).

%% =========================
%% 5. Pipeline completo
%% =========================
fbf_a_clausal(F, Clausulas) :-
    rmImpl(F,  F1),
    simNeg(F1, F2),
    fnc(F2,    F3),
    clausulas(F3, Clausulas).

%% ===============================
%% 6. resolucion una sola clausula 
%% ================================
complementario(~X, X)  :- !.
complementario(X, ~X).

resAux([], X, X).
resAux(X, [], X).
resAux([X], [~X], []).
resAux(Central, Clausula, Resolvente):-
    \+ (member(X, Central), member(X2, Clausula), complementario(X, X2)),
    append(Central, Clausula, Raux),
    list_to_set(Raux, Resolvente).

resAux(Central, Clausula, Resolvente):-
    member(X, Central),
    member(X2, Clausula),
    complementario(X, X2),
    delete(Central, X, L),
    delete(Clausula, X2, L2),
    resAux(L, L2, Resolvente).

%% =========================
%% 7. resolucion Completa con una clausula central
%% =========================

%resulucionLineal(Listadelistas, resultado).
resolucionLineal([], []).
resolucionLineal([[A]], [A]).
resolucionLineal([Clausula1, Clausula2], Resultado):-
    resAux(Clausula1, Clausula2, Resultado).
resolucionLineal([Cabeza, C1 |Cola], Resultado):-
    resAux(Cabeza, C1, Solucion1),
    append(Solucion1, Cola, NuevaLista),
    resolucionLineal(NuevaLista, Resultado).

resLineal([], _, []) :- !.
resLineal(Central, [], Central).
resLineal(Central, [Clausula|Resto], RES):-   
    resAux(Central, Clausula, NuevoCentral),
    resLineal(NuevoCentral, Resto, RES).
    
%% =========================
%% 8. UNIFICACION: 
%% =========================

resolver(F, Solucion) :-
    fbf_a_clausal(F, C), 
    resLineal(C, Solucion).