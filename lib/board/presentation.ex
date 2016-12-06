defmodule Board.Presentation do

@template "
  1 | 2 | 3 
  ----------
A a | b | c 
  ----------
B d | e | f 
  ----------
C g | h | i "  

  def render([a,b,c,d,e,f,g,h,i], mark_to_string) do
    String.replace(@template, "a", mark_to_string[a]) 
     |> String.replace("b", mark_to_string[b]) 
     |> String.replace("c", mark_to_string[c]) 
     |> String.replace("d", mark_to_string[d]) 
     |> String.replace("e", mark_to_string[e]) 
     |> String.replace("f", mark_to_string[f]) 
     |> String.replace("g", mark_to_string[g]) 
     |> String.replace("h", mark_to_string[h]) 
     |> String.replace("i", mark_to_string[i]) 
  end

end
