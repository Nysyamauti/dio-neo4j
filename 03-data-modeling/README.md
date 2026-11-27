# 📋 Graph Data Modeling

## 📝 Context
This module covers the core of graph data modeling best practices, deepening the concepts of nodes, relationships, properties, and labels.

## 📌 Lessons and Topics

### Node
> The fundamental data unit that represents an entity, such as a person, product, or company.

### Relationship
> Core elements in a graph database that connect two nodes, defining how entities are related and always having a direction and a type.

### Properties
> Key-value pairs used to store data inside both nodes and relationships.

### Labels
> Tags (or markers) applied to a node (a discrete object in a graph database) to classify and group it with similar nodes.

### Best Practices
* **Appropriate Labels:** Avoid creating overly granular labels for values or temporary states (use properties instead); reserve labels for distinct entity roles and fast entry-point lookups.
* **Intermediate Nodes:** When a relationship requires multiple properties or connects more than two entities (e.g., an order with date, total, and payment method), extract it into an intermediate node (e.g., `:Order`) to simplify querying and modeling.
* **Specific Relationship Types:** Prefer specific, action-oriented relationship types (e.g., `[:PURCHASED]`, `[:DIRECTED]`) over generic ones (e.g., `[:HAS]`, `[:RELATED_TO]`) to improve traversal performance.
* **Avoid Supernodes:** Be cautious with nodes that accumulate a massive number of relationships, as traversing dense nodes can become a performance bottleneck.
* **Query-Driven Modeling:** Design your graph structure based on the specific business questions and traversal paths your application needs to answer.