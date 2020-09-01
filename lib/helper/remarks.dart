Remarks(goal, total, present) {
  double percentage = total != 0 ? present / total * 100 : 0;
  if (percentage < goal) {
    int count = 0;
    while (percentage < goal) {
      total = total + 1;
      present = present + 1;
      percentage = present / total * 100;
      count = count + 1;
    }
    return "Must attend next ${count} class(s)";
  } else if (percentage >= goal) {
    int count = -1;
    while (percentage >= goal) {
      total = total + 1;
      count = count + 1;
      percentage = present / total * 100;
    }
    if (count == 0 || count == 1) {
      return "Must attend next class";
    }
    return "May leave next ${count} class(s)";
  }
}
