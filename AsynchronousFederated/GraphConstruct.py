from mpi4py import MPI
import numpy as np
import networkx as nx


class GraphConstruct:

    def __init__(self, graph, rank, size, p=0.75, num_c=None):

        # Initialize MPI variables
        self.rank = rank  # index of worker
        self.size = size  # totoal number of workers
        self.comm = MPI.COMM_WORLD

        # Create graph from string input or return custom inputted graph
        self.graph = self.selectGraph(graph, p, num_c)

        # Determine each node's neighbors and the weights for each node in the Graph
        self.neighbor_list = self.getNeighbors(rank)
        self.neighbor_weights = self.getWeights()

    def selectGraph(self, graph, p, num_c):

        if isinstance(graph, list):
            return graph
        else:
            g = []
            if graph == 'fully-connected':
                fc_graph = nx.complete_graph(self.size)
                g = fc_graph.edges
                # for i in range(self.size):
                #    for j in range(i+1, self.size):
                #        g.append((i, j))

            elif graph == 'ring':
                for i in range(self.size):
                    if i != self.size - 1:
                        g.append((i, i+1))
                    else:
                        g.append((i, 0))

            elif graph == 'clique-ring':
                per_c = int(self.size/num_c)
                rem = self.size % num_c
                print(per_c)
                print(rem)
                for i in range(num_c):
                    if i != num_c-1:
                        fc_graph = nx.complete_graph(per_c)
                        fc_graph = nx.convert_node_labels_to_integers(fc_graph, i*per_c)
                        g += fc_graph.edges
                        g.append((per_c-1, per_c))
                    else:
                        fc_graph = nx.complete_graph(per_c + rem)
                        fc_graph = nx.convert_node_labels_to_integers(fc_graph, i*per_c)
                        g += fc_graph.edges
                        if num_c > 2:
                            g.append((self.size-1, 0))
                print(g)

            elif graph == 'erdos-renyi':
                if self.rank == 0:
                    while True:
                        erdos_graph = nx.erdos_renyi_graph(self.size, p)
                        if nx.is_connected(erdos_graph):
                            g = erdos_graph.edges
                            num_edges = len(g)*np.ones(1, dtype=np.int)
                            print('Generated Erdos-Renyi Graph Edges:')
                            print(g)
                            break
                else:
                    num_edges = np.zeros(1, dtype=np.int)
                MPI.COMM_WORLD.Bcast(num_edges, root=0)
                num_edges = num_edges[0]
                if self.rank != 0:
                    data = np.empty((num_edges, 2), dtype=np.int)
                else:
                    data = np.array(g, dtype=np.int)
                MPI.COMM_WORLD.Bcast(data, root=0)
                if self.rank != 0:
                    for i in range(num_edges):
                        g.append((data[i][0], data[i][1]))

            return g

    def getWeights(self, weight_type=None):
        
        if weight_type == 'learnable':
            # NEED TO IMPLEMENT HERE
            weights = np.ones(self.size)
            
        elif weight_type == 'matcha':
            # NEED TO IMPLEMENT HERE
            weights = np.ones(self.size)
            
        else:
            num_neighbors = len(self.neighbor_list)
            weights = (1/num_neighbors) * np.ones(num_neighbors)
            
        return weights

    def getNeighbors(self, rank):
        
        neighbors = [[] for _ in range(self.size)]
        for edge in self.graph:
            node1, node2 = edge[0], edge[1]
            if node1 == node2:
                print("Invalid input graph! Circle! ("+str(node1) +", "+ str(node2)+")")
                exit()
            neighbors[node1].append(node2)
            neighbors[node2].append(node1)
            
        return neighbors[rank]
    