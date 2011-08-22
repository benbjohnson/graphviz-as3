graphviz-as3
=============================================

## DESCRIPTION

This is an interface between Flash and the Graphviz layout engine. It uses the
Adobe AIR native process functionality so it will only work with native
applications.

Graphviz-as3 follows the rules of [Semantic Versioning](http://semver.org/).


## GETTING STARTED

### Overview

The Graphviz AS3 API allows you to use Sprites in your graph but it outsources
the layout of the graph to the Graphviz program. To construct a graph, you
add nodes, edges and subgraphs to it. Once your nodes and edges are in place,
you can call `Graph.layout()`. The `Event.COMPLETE` event will fire when the
layout has been performed by Graphviz and your graph is ready to be displayed.


### Graph Elements

There are two types of graphs: undirected and directed graphs. Directed graphs
have edges that point to another node whereas undirected graphs do not have
a direction.

There are three types of elements to add to a graph:

* `Node` - An element that is linked to by one or more edges.
* `Edge` - A connector between two nodes.
* `Subgraph` - A collection of nodes that is contained in a box.


## CONTRIBUTE

Send a pull request with some sweet code! However, if you're sending code,
please add tests and use a named branch. Thanks!
