def update_stats(r, stats):
    """This function updates the stats of each player in a round"""
    for p in r:
        stats[p]['kills'] += r[p]['kills']
        stats[p]['assists'] += r[p]['assists']
        stats[p]['deaths'] += (1 if r[p]['deaths'] else 0)
    return

def counting_points_mvps(round, stats):
    """This function counts the points of each player in a round, obtains the mvp, 
    updates both them in a dictionary and returns the mvp."""
    mvp_points = (-99)
    for p in round:
        round_points = (round[p]['kills'] * 3) + (round[p]['assists']) + ((-1) if (round[p]['deaths']) else 0)
        if (round_points > mvp_points):
            mvp_points = round_points
            mvp = p        
        stats[p]['points'] += round_points
    stats[mvp]['mvps'] += 1
    return mvp

def print_round(stats, mvp):
    """This function prints the stats of a round"""
    sorted_stats = dict(sorted(stats.items(), key=lambda x:x[1]['points'], reverse=True))
    print("------------------------------------------------------")
    print("Player    Kills    Assists    Deaths    MVPs    Points")
    for p in sorted_stats:
        print(f"{p:<12}{sorted_stats[p]['kills']:<10}{sorted_stats[p]['assists']:<10}{sorted_stats[p]['deaths']:<9}\
{sorted_stats[p]['mvps']:<9}{sorted_stats[p]['points']:<5}" + ("mvp" if p == mvp else ""))
    print("------------------------------------------------------")
    return