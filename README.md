# Demostrador automático de teoremas en Prolog

**ES** · [EN](#english)

Demostrador de teoremas basado en **resolución lineal**, escrito en Prolog. Trabajo en equipo (3 personas) de la asignatura de Programación Declarativa (UCLM).

## Qué incluye

- Definición de operadores lógicos: negación `~`, conjunción `/\`, disyunción `\/` e implicación `=>`.
- Paso a **forma clausal**: eliminación de implicaciones, forma normal negativa y distribución.
- **Resolución lineal** sobre el conjunto de cláusulas (`resolucionLineal/2`) y predicado principal `resolver(F, Solucion)`.
- `informe.pdf`: memoria con los conceptos (forma clausal y resolución lineal) y el diseño.

## Uso

Con SWI-Prolog instalado:

```
swipl -s trabajoTeorico.pl
```

Después, en el intérprete, consulta `resolver(Formula, Solucion).` con una fórmula escrita con los operadores anteriores.

## Créditos

Equipo: **Sara de la Hoz Escuderos**, **Marcos Hurtado Morcillo** y **Marcos Galán Rodríguez**.

---

## English

Automated theorem prover based on **linear resolution**, written in Prolog. Team project (3 people) for the Declarative Programming course (UCLM, Spain).

### Features

- Logical operators: negation `~`, conjunction `/\`, disjunction `\/` and implication `=>`.
- Conversion to **clausal form**: implication removal, negation normal form and distribution.
- **Linear resolution** over the clause set (`resolucionLineal/2`) with the main predicate `resolver(F, Solucion)`.
- `informe.pdf`: report on the concepts (clausal form and linear resolution) and the design, written in Spanish.

### Usage

With SWI-Prolog installed:

```
swipl -s trabajoTeorico.pl
```

Then query `resolver(Formula, Solucion).` with a formula written using the operators above.

### Credits

Team: **Sara de la Hoz Escuderos**, **Marcos Hurtado Morcillo** and **Marcos Galán Rodríguez**.
