# Basic to Intermediate Cypher

## About
This module covers the core of basic and intermediate Cypher, including essential clauses, functions, and theoretical concepts.

## Lessons & Topics

### Part 1 - Introduction to Cypher Query Language
The first step includes the syntax structure and functions of the fundamental Cypher clauses.

#### Essential Code Structure
* **`()`:** Represent **nodes** (entities).
* **`[]`:** Represent **relationships**.
* **`{}`:** Store **properties** (key-value pairs) in both nodes and relationships.
* **`<-` or `->`:** Indicate the **direction** of a relationship.

#### Match & Return
* **`Match`:** Finds existing nodes, relationships, or patterns in the graph.
* **`RETURN`:** Displays the results found by a `MATCH` (or other clauses).

#### Create
* **`CREATE`:** Always creates new nodes or relationships, even if they already exist (unlike `MERGE`). Relationships must always specify a direction when created.

#### Set & Remove
* **`SET`:** Adds or updates properties and labels on nodes, or properties on relationships.
* **`REMOVE`:** Removes properties or labels from nodes and relationships.

#### Delete
* **`Delete`:** Deletes nodes and relationships. Neo4j does not allow deleting a node that still has active relationships.

### Part 2 - Mini Project: Music Recommendation Algorithm
A practical hands-on challenge applying Cypher queries to build a graph-based music recommendation engine using nodes (`User`, `Song`, `Composer`, `Genre`) and interaction relationships (`LISTENED`, `LIKED`, `FOLLOWS`).

* 👉 **[Access the Mini Project & Cypher Scripts](./mini-project/)**