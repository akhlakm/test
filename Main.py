import streamlit as st

# Set webpage title
st.set_page_config(page_title="Streamlit Test")

st.write(f"# Streamlit Test for Websocket connection")

st.markdown(
    """
    Run NLP Pipelines using web-based user interface.

    **👈 Please select a pipeline from the sidebar.**

    ### Available Pipelines
    - **NER Pipeline** - Parse and extract data from a html file using MaterialsBERT.
 
    Return to [Polymer Scholar](https://polymerscholar.org/).
"""
)

